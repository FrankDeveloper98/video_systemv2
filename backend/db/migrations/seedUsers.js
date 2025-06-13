const db = require('../../config/db');
const bcrypt = require('bcrypt');

async function seedUsers(count = 50) {
  const users = [];
  for (let i = 1; i <= count; i++) {
    const name = `user${i}`;
    const lastname = `lastname${i}`;
    const email = `user${i}@example.com`;
    const password = await bcrypt.hash(`password${i}`, 10);
    const phone = `09999999${String(i).padStart(2, '0')}`;
    users.push({ name, lastname, email, password, phone });
  }
  for (const user of users) {
    await db.none(
      'INSERT INTO users (name, lastname, email, password, phone) VALUES ($1, $2, $3, $4, $5)',
      [user.name, user.lastname, user.email, user.password, user.phone]
    );
  }
  console.log(`${count} users seeded.`);
}

// Change the number here to seed a different amount
seedUsers(50)
  .then(() => process.exit(0))
  .catch((err) => { console.error(err); process.exit(1); });
