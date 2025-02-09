from plyer import notification
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import mysql.connector
import time
from selenium.common.exceptions import TimeoutException, WebDriverException

# Database Configuration
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',  # Replace with your MySQL username
    'password': 'Bhagya@27',  # Replace with your MySQL password
    'database': 'mentorx'
}

def send_notification(title, message):
    """
    Sends a push notification to the desktop.
    """
    notification.notify(
        title=title,
        message=message,
        app_name="Hackathon Scraper",
        timeout=10  # Duration of notification in seconds
    )

def connect_to_database():
    """
    Establishes a connection to the MySQL database.
    """
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        send_notification("Database Connection", "Successfully connected to the database.")
        return conn
    except mysql.connector.Error as err:
        send_notification("Database Error", f"Error connecting to database: {err}")
        return None

def save_to_database(hackathons):
    """
    Saves the scraped hackathon data into the database.
    """
    conn = connect_to_database()
    if conn:
        cursor = conn.cursor()
        # Create table if it does not exist
        create_table_query = """
        CREATE TABLE IF NOT EXISTS hackathons (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            date VARCHAR(255),
            prize VARCHAR(255),
            participants VARCHAR(255),
            location VARCHAR(255),
            categories VARCHAR(255),
            UNIQUE(title)
        );
        """
        cursor.execute(create_table_query)

        insert_query = """
            INSERT INTO hackathons (title, date, prize, participants, location, categories)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                date = VALUES(date),
                prize = VALUES(prize),
                participants = VALUES(participants),
                location = VALUES(location),
                categories = VALUES(categories);
        """
        for hackathon in hackathons:
            try:
                cursor.execute(insert_query, hackathon)
            except mysql.connector.Error as err:
                print(f"Error inserting data: {err}")

        conn.commit()
        cursor.close()
        conn.close()
        send_notification("Data Saved", "Hackathon data has been saved to the database successfully.")

def scrape_all_hackathons():
    """
    Scrapes all hackathons from the DevPost URL.
    """
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
    base_url = "https://devpost.com/hackathons?challenge_type[]=online&challenge_type[]=in-person&length[]=days&status[]=upcoming&status[]=open"
    hackathons = set()  # Use a set to avoid duplicates

    try:
        driver.get(base_url)
        send_notification("Scraping Started", "Fetching hackathon data from DevPost.")

        # Wait for the initial page load
        WebDriverWait(driver, 20).until(
            EC.presence_of_all_elements_located((By.CLASS_NAME, 'hackathon-tile'))
        )

        last_count = 0  # Tracks the number of hackathons found
        retries = 0
        max_retries = 3

        while retries < max_retries:  # Stop after max_retries unsuccessful attempts to load more content
            # Scroll to the bottom of the page
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(5)  # Wait for new content to load

            # Collect all hackathon tiles
            cards = driver.find_elements(By.CLASS_NAME, 'hackathon-tile')
            current_count = len(cards)

            print(f"Found {current_count} hackathons so far...")

            # If no new hackathons are loaded, increment retries
            if current_count == last_count:
                retries += 1
                print(f"No new hackathons found. Retry {retries}/{max_retries}...")
            else:
                retries = 0  # Reset retries if new content is loaded
                last_count = current_count

            # Extract data from each card
            for card in cards:
                try:
                    # Extract title
                    title_element = card.find_element(By.CSS_SELECTOR, 'h3')
                    title = title_element.text.strip() if title_element else "N/A"

                    # Extract additional data
                    date_element = card.find_element(By.CSS_SELECTOR, '.submission-period')
                    date = date_element.text.strip() if date_element else "N/A"

                    prize_element = card.find_element(By.CSS_SELECTOR, '.prize-amount')
                    prize = prize_element.text.strip() if prize_element else "N/A"

                    participants_element = card.find_element(By.CSS_SELECTOR, '.participants strong')
                    participants = participants_element.text.strip() if participants_element else "N/A"

                    location_element = card.find_element(By.CSS_SELECTOR, '.info-with-icon span')
                    location = location_element.text.strip() if location_element else "N/A"

                    # Extract categories
                    categories_elements = card.find_elements(By.CSS_SELECTOR, '.themes .theme-label')
                    categories = ', '.join([cat.text.strip() for cat in categories_elements if cat.text.strip()])

                    # Add to set
                    hackathons.add((title, date, prize, participants, location, categories))

                    # Personalized notification for each hackathon
                    notification_message = f"Date: {date}\nPrize: {prize}\nLocation: {location}\nCategories: {categories}"
                    send_notification(f"New Hackathon: {title}", notification_message)

                except Exception as e:
                    print(f"Error extracting data for a hackathon: {e}")

        print(f"Total unique hackathons found: {len(hackathons)}")

    except Exception as e:
        send_notification("Scraping Error", f"An error occurred: {e}")
        print(f"An error occurred: {e}")

    finally:
        driver.quit()

    return hackathons

if __name__ == "__main__":
    hackathons = scrape_all_hackathons()
    if hackathons:
        send_notification("Scraping Complete", f"Found {len(hackathons)} unique hackathons.")
        save_to_database(hackathons)
    else:
        send_notification("No Hackathons Found", "No hackathons were found or an error occurred.")
