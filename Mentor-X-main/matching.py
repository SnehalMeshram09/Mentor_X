import mysql.connector

DB_HOST = "localhost"
DB_NAME = "mentorx"
DB_USER = "root"
DB_PASS = "root123"  


def calculate_team_score(user_skills, match_skills, user_city, match_city):
    user_skills = set(user_skills.split(", "))
    match_skills = set(match_skills.split(", "))
    common_skills = user_skills.intersection(match_skills)

    skills_similarity = len(common_skills) / max(len(user_skills), len(match_skills))

    score = 0
    score += skills_similarity * 80  # Skills similarity (scaled)
    if user_city == match_city:
        score += 20  # City match

    return score


def parse_input(user_input):
    """Extract skills and city from user input."""
    user_input = user_input.lower()
    city = None
    skills = []

    # Define a set of stop words to ignore
    stop_words = {"i", "want", "a", "person", "with", "and", "the", "from", "to", "recommend", "me", "team", "member","Skills","skill","if","he/she","he","she","find"}

    # Extract city if "from <city>" is mentioned
    if "from" in user_input:
        city_part = user_input.split("from")[-1].strip()
        if " " in city_part:
            city = city_part.split(" ")[0]
        else:
            city = city_part

    # Extract skills by separating comma-separated skills or using "and"
    skills_part = user_input.replace(" and ", ",").split("from")[0]
    words = skills_part.split()
    skills = [word.strip() for word in words if word not in stop_words]

    return skills, city


def main():
    name = input("Enter your name: ").strip()

    user_input = input("What are you looking for? (You can mention skills and city): ").strip()

    skills, location = parse_input(user_input)

    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASS
        )
        cursor = conn.cursor(dictionary=True)

        # Fetch user data with case-insensitive search
        cursor.execute("SELECT * FROM users WHERE LOWER(name) = LOWER(%s)", (name,))
        user = cursor.fetchone()
        if not user:
            print("User not found!")
            return

        user_skills = user["skills"]
        user_city = user["city"]

        # Build query for potential matches
        query = "SELECT * FROM users WHERE LOWER(name) != LOWER(%s)"
        params = [name]

        if location:
            query += " AND LOWER(city) = LOWER(%s)"
            params.append(location.lower())

        if skills:
            # Use a LIKE query for more flexible skill matching
            skills_conditions = " OR ".join([f"LOWER(skills) LIKE %s" for _ in skills])
            query += f" AND ({skills_conditions})"
            params.extend([f"%{skill.lower()}%" for skill in skills])

        print(f"Executing query: {query}")
        print(f"With parameters: {params}")

        cursor.execute(query, tuple(params))
        matches = cursor.fetchall()

        recommendations = []
        for match in matches:
            score = calculate_team_score(user_skills, match["skills"], user_city, match["city"])
            recommendations.append({
                "Name": match["name"],
                "Score": score,
                "Skills": match["skills"],
                "City": match["city"],
                "College": match["college_name"],
                "GitHub": match["github_id"],
                "LinkedIn": match["linkedin_id"]
            })

        recommendations.sort(key=lambda x: x["Score"], reverse=True)

        # Display results
        print("\nRecommended Team Members:")
        if recommendations:
            for rec in recommendations:
                print(f"Name: {rec['Name']}, Score: {rec['Score']}, Skills: {rec['Skills']}, City: {rec['City']}, "
                      f"College: {rec['College']}, GitHub: {rec['GitHub']}, LinkedIn: {rec['LinkedIn']}")
        else:
            print("No matching team members found.")

    except mysql.connector.Error as err:
        print(f"Error: {err}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()


if __name__ == "__main__":
    main()