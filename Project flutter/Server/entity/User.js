const { Entity, PrimaryGeneratedColumn, Column } = require("typeorm");

@Entity()
class User {
  @PrimaryGeneratedColumn()
  id;

  @Column()
  username;

  @Column()
  password;

  @Column()
  gmail;
}

module.exports = User;
