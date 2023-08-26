const express = require('express');
const bodyParser = require('body-parser');
const { Pool } = require('pg');
const { v4: uuidv4 } = require('uuid');

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
    const session = req.body;
    const { reps_per_set} = session;
    // Basic SQL query to insert workout into a table
    const query = ```
    INSERT INTO sets
    (
     session_id, 
     set_1, set_2, set_3, set_4, set_5, set_6, set_7, set_8, set_9, set_10,  
     rpe_1, rpe_2, rpe_3, rpe_4, rpe_5, rpe_6, rpe_7, rpe_8, rpe_9, rpe_10,  
     timestamp
    ) 
    VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22)
    ```;
    const session_id = uuidv4();
    const timestamp = Date.now();
    const values = [session_id, rpe, ...reps_per_set, timestamp];

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

