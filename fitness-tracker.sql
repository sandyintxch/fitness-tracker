-- Creating the tables users, exercises and workout_sessions
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(50) UNIQUE,
    birth_date DATE,
    gender VARCHAR(10) CHECK(gender IN ('Male', 'Female', 'Other'))
);

CREATE TABLE exercises (
    exercise_id INT PRIMARY KEY,
    exercise_name VARCHAR(50) UNIQUE,
    category VARCHAR(50),
    calories_burned_per_hour INT
);

CREATE TABLE workout_sessions (
    session_id INT PRIMARY KEY,
    user_id INT,
    exercise_id INT,
    date DATE,
    duration_minutes INT,
    calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (exercise_id) REFERENCES exercises(exercise_id)
);

-- Inserting data into tables
INSERT INTO users VALUES
(1, 'sandra_edmund', 'thisissandra.o@gmail.com', '1996-07-23', 'Female'),
(2, 'alice_1987', 'alice@email.com', '1987-03-12', 'Female'),
(3, 'bob_1995', 'bob@email.com', '1995-08-28', 'Male'),
(4, 'charlie_1980', 'charlie@email.com', '1980-11-05', 'Other');

INSERT INTO exercises VALUES
(1, 'Running', 'Cardio', 600),
(2, 'Weightlifting', 'Strength Training', 300);

INSERT INTO workout_sessions VALUES
(1, 1, 1, '2023-01-10', 30, 300),
(2, 1, 2, '2023-01-12', 45, 200),
(3, 2, 1, '2023-01-11', 20, 200),
(4, 2, 2, '2023-01-14', 60, 400);

-- Retrieve all workout sessions with user information
SELECT users.username, exercises.exercise_name, workout_sessions.date, workout_sessions.duration_minutes
FROM workout_sessions
JOIN users ON workout_sessions.user_id = users.user_id
JOIN exercises ON workout_sessions.exercise_id = exercises.exercise_id;

-- Calculate total calories burned by each user
SELECT users.username, SUM(workout_sessions.calories_burned) AS total_calories_burned
FROM workout_sessions
JOIN users ON workout_sessions.user_id = users.user_id
GROUP BY users.username;

-- Find users who burned more than 300 calories in a single session
SELECT users.username, workout_sessions.date, workout_sessions.calories_burned
FROM workout_sessions
JOIN users ON workout_sessions.user_id = users.user_id
WHERE workout_sessions.calories_burned > 300;
DELETE FROM workout_sessions WHERE session_id = 1;

-- Retrieve the average duration of exercises by category
SELECT exercises.category, AVG(workout_sessions.duration_minutes) AS avg_duration
FROM workout_sessions
JOIN exercises ON workout_sessions.exercise_id = exercises.exercise_id
GROUP BY exercises.category;

