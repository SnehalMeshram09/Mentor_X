from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import mysql.connector
import time

# Database Configuration
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',         # Replace with your MySQL username
    'password': 'Siddhi#19', # Replace with your MySQL password
    'database': 'mentorx'
}

def connect_to_database():
    """
    Establishes a connection to the MySQL database.
    """
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        print("Connected to the database.")
        return conn
    except mysql.connector.Error as err:
        print(f"Error connecting to database: {err}")
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
            dates VARCHAR(255),
            prize VARCHAR(255),
            participants VARCHAR(255),
            location VARCHAR(255),
            categories VARCHAR(255),
            UNIQUE(title)
        );
        """
        cursor.execute(create_table_query)

        insert_query = """
            INSERT INTO hackathons (title, dates, prize, participants, location, categories)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                dates = VALUES(dates),
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
        print("Data saved to database successfully.")
        update_start_date_in_database()

def update_start_date_in_database():
    """
    Updates the database to parse and add the start_date column from the 'dates' field.
    """
    conn = connect_to_database()
    if conn:
        cursor = conn.cursor()

        # # Add start_date column if it doesn't exist
        # alter_table_query = """
        # ALTER TABLE hackathons
        # ADD COLUMN IF NOT EXISTS start_date DATE;
        # """
        # cursor.execute(alter_table_query)

        # Update start_date based on the 'dates' field
        update_start_date_query = """
        UPDATE hackathons
        SET
            start_date = STR_TO_DATE(
                CASE
                    WHEN dates LIKE '%-%' THEN
                        CONCAT(
                            SUBSTRING_INDEX(dates, ' ', 1), ' ',            -- Start month
                            CASE
                                WHEN LOCATE('-', SUBSTRING_INDEX(dates, ' ', 2)) > 0 THEN
                                    SUBSTRING_INDEX(SUBSTRING_INDEX(dates, ' ', 2), '-', 1)  -- Start day (e.g., jan 31 - feb 04)
                                ELSE
                                    SUBSTRING_INDEX(SUBSTRING_INDEX(dates, ' ', 2), ' ', -1) -- Start day (e.g., jan 10 - 12)
                            END,
                            ', ',
                            RIGHT(dates, 4)                                -- Year
                        )
                    ELSE
                        CONCAT(
                            SUBSTRING_INDEX(dates, ' ', 1), ' ',           -- Month
                            SUBSTRING_INDEX(dates, ' ', -2),               -- Day
                            ', ',
                            RIGHT(dates, 4)                                -- Year
                        )
                END,
                '%b %d, %Y'
            )
        WHERE dates IS NOT NULL AND dates != '';
        """
        try:
            cursor.execute(update_start_date_query)
            conn.commit()
            print("start_date updated successfully.")
        except mysql.connector.Error as err:
            print(f"Error updating start_date: {err}")
        finally:
            cursor.close()
            conn.close()



def scrape_all_hackathons():
    """
    Scrapes all hackathons from the DevPost URL.
    """
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
    base_url = "https://devpost.com/hackathons?challenge_type[]=online&challenge_type[]=in-person&length[]=days&status[]=upcoming&status[]=open"
    hackathons = set()  # Use a set to avoid duplicates

    try:
        driver.get(base_url)

        # Wait for the initial page load
        WebDriverWait(driver, 20).until(
            EC.presence_of_all_elements_located((By.CLASS_NAME, 'hackathon-tile'))
        )

        last_count = 0  # Tracks the number of hackathons found
        retries = 0

        while retries < 2:  # Stop after 2 unsuccessful attempts to load more content
            # Scroll to the bottom of the page
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(8)  # Wait longer for new content to load

            # Collect all hackathon tiles
            cards = driver.find_elements(By.CLASS_NAME, 'hackathon-tile')
            current_count = len(cards)

            print(f"Found {current_count} hackathons so far...")

            # If no new hackathons are loaded, increment retries
            if current_count == last_count:
                retries += 1
                print(f"No new hackathons found. Retry {retries}/2...")
            else:
                retries = 0  # Reset retries if new content is loaded
                last_count = current_count

            # Extract data from each card
            for card in cards:
                try:
                    # Extract title
                    title_element = card.find_element(By.CSS_SELECTOR, 'h3')
                    title = title_element.text.strip().lower() if title_element else "n/a"

                    # Extract additional data
                    date_element = card.find_element(By.CSS_SELECTOR, '.submission-period')
                    dates = date_element.text.strip().lower() if date_element else "n/a"

                    prize_element = card.find_element(By.CSS_SELECTOR, '.prize-amount')
                    prize = prize_element.text.strip().lower() if prize_element else "n/a"

                    participants_element = card.find_element(By.CSS_SELECTOR, '.participants strong')
                    participants = participants_element.text.strip().lower() if participants_element else "n/a"

                    location_element = card.find_element(By.CSS_SELECTOR, '.info-with-icon span')
                    location = location_element.text.strip().lower() if location_element else "n/a"

                    # Extract categories
                    categories_elements = card.find_elements(By.CSS_SELECTOR, '.themes .theme-label')
                    categories = ', '.join([cat.text.strip().lower() for cat in categories_elements if cat.text.strip()])

                    # Add to set
                    hackathons.add((title, dates, prize, participants, location, categories))
                except Exception as e:
                    print(f"Error extracting data for a hackathon: {e}")

        print(f"Total unique hackathons found: {len(hackathons)}")

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        driver.quit()

    return hackathons


# Run the scraper and save to the database
if __name__ == "__main__":
    hackathons = scrape_all_hackathons()
    if hackathons:
        print("Scraped Hackathons:")
        for hackathon in hackathons:
            print(f"Title: {hackathon[0]}")
            print(f"Dates: {hackathon[1]}")
            print(f"Prize: {hackathon[2]}")
            print(f"Participants: {hackathon[3]}")
            print(f"Location: {hackathon[4]}")
            print(f"Categories: {hackathon[5]}")
            print("-" * 50)

        # Save data to the database
        save_to_database(hackathons)
    else:
        print("No hackathons found or an error occurred.")
