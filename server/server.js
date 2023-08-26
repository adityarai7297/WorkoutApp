const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const app = express();
const port = 3000;

// Connect to the RDS PostgreSQL instance
const pool = new Pool({
  host: 'YOUR_RDS_ENDPOINT',
  user: 'YOUR_DB_USERNAME',
  password: 'YOUR_DB_PASSWORD',
  database: 'YOUR_DB_NAME',
  port: 5432,
  ssl: { rejectUnauthorized: false }  // For demo purposes only
});

app.use(bodyParser.json());

// Sample endpoint to add a workout
app.post('/addSet', async (req, res) => {
  try {
    const workout = req.body;

    // Basic SQL query to insert workout into a table
    const query = 'INSERT INTO workouts(name, reps, rpe, timestamp) VALUES($1, $2, $3, $4)';
    const values = [workout.name, workout.sets];

    await pool.query(query, values);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Internal server error' });
  }
});

// Sample endpoint to add a workout
app.post('/addWorkout', async (req, res) => {
  try {
    const workout = req.body;

    // Basic SQL query to insert workout into a table
    const query = 'INSERT INTO workouts(workout, sets) VALUES($1, $2)';
    const values = [workout.name, workout.sets];

    await pool.query(query, values);
    res.json({ success: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ success: false, message: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

