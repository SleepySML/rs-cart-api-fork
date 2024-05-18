import { Pool } from 'pg';

const connectionTimeoutMillis = 10000;

const queryOptions = {
  host: process.env.DB_HOST,
  port: +process.env.DB_PORT,
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  connectionTimeoutMillis,
  ssl: {
    rejectUnauthorized: false // If using self-signed certificates
  },
};

let pool: Pool;

export const lookup = async (query: string) => {
  if (!pool) {
    pool = new Pool(queryOptions);
  }

  const client = await pool.connect();

  try {
    return await client.query(query);
  } catch (error) {
    console.log(`Error caught: ${error}`);
  } finally {
    client.release();
  }
};