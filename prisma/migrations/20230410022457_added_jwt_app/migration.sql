/*
  Warnings:

  - You are about to drop the column `hash` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `hashedRt` on the `users` table. All the data in the column will be lost.
  - You are about to alter the column `email` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(64)`.
  - You are about to drop the `user apps` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `password_hash` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "user apps" DROP CONSTRAINT "user apps_userId_fkey";

-- AlterTable
ALTER TABLE "users" DROP COLUMN "hash",
DROP COLUMN "hashedRt",
ADD COLUMN     "password_hash" VARCHAR(256) NOT NULL,
ALTER COLUMN "email" SET DATA TYPE VARCHAR(64);

-- DropTable
DROP TABLE "user apps";

-- CreateTable
CREATE TABLE "apps" (
    "id" SERIAL NOT NULL,
    "status" VARCHAR(16) NOT NULL,
    "build_logs" VARCHAR(2048) NOT NULL,
    "deploy_logs" VARCHAR(2048) NOT NULL,

    CONSTRAINT "apps_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "jwts" (
    "id" SERIAL NOT NULL,
    "access_hash" VARCHAR(256) NOT NULL,
    "refresh_hash" VARCHAR(256) NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "jwts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(128) NOT NULL,
    "variables" JSONB NOT NULL,
    "user_id" INTEGER NOT NULL,
    "app_id" INTEGER NOT NULL,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "projects_app_id_key" ON "projects"("app_id");

-- AddForeignKey
ALTER TABLE "jwts" ADD CONSTRAINT "jwts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "projects" ADD CONSTRAINT "projects_app_id_fkey" FOREIGN KEY ("app_id") REFERENCES "apps"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
