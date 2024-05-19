const { Entity, PrimaryGeneratedColumn, Column } = require("typeorm");

@Entity()
class Task {
  @PrimaryGeneratedColumn()
  id;

  @Column()
  title;

  @Column({ nullable: true })
  description;

  @Column({ default: false })
  isDone;

  @Column({ default: () => "CURRENT_TIMESTAMP" })
  createdAt;
}

module.exports = Task;
