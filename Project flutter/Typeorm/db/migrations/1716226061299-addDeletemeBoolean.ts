import { MigrationInterface, QueryRunner } from "typeorm";

export class AddDeletemeBoolean1716226061299 implements MigrationInterface {
    name = 'AddDeletemeBoolean1716226061299'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "user" ADD "deleteme" boolean NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "user" DROP COLUMN "deleteme"`);
    }

}
