-- CreateEnum
CREATE TYPE "role" AS ENUM ('SUPERADMIN', 'ADMIN', 'USER');

-- CreateTable
CREATE TABLE "user" (
    "userId" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "role" "role" NOT NULL DEFAULT 'USER',

    CONSTRAINT "user_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "category" (
    "catId" SERIAL NOT NULL,
    "cat_type" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("catId")
);

-- CreateTable
CREATE TABLE "subcategory" (
    "subId" SERIAL NOT NULL,
    "subename" TEXT NOT NULL,
    "subimage" TEXT NOT NULL,
    "discription" TEXT,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "cat_catId" INTEGER NOT NULL,

    CONSTRAINT "subcategory_pkey" PRIMARY KEY ("subId")
);

-- CreateTable
CREATE TABLE "product" (
    "proId" SERIAL NOT NULL,
    "proname" TEXT NOT NULL,
    "proStock" INTEGER NOT NULL,
    "proPrice" DECIMAL(65,30) NOT NULL,
    "proimage" TEXT NOT NULL,
    "proDescription" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "catId" INTEGER NOT NULL,
    "autherId" INTEGER NOT NULL,

    CONSTRAINT "product_pkey" PRIMARY KEY ("proId")
);

-- CreateTable
CREATE TABLE "cart" (
    "cartid" SERIAL NOT NULL,
    "careatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL,
    "autherId" INTEGER NOT NULL,

    CONSTRAINT "cart_pkey" PRIMARY KEY ("cartid")
);

-- CreateTable
CREATE TABLE "cartItem" (
    "cartItemId" SERIAL NOT NULL,
    "careatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL,
    "cartId" INTEGER NOT NULL,
    "porid" INTEGER NOT NULL,

    CONSTRAINT "cartItem_pkey" PRIMARY KEY ("cartItemId")
);

-- CreateTable
CREATE TABLE "menu" (
    "menuId" SERIAL NOT NULL,
    "menuname" TEXT NOT NULL,
    "menuImage" TEXT NOT NULL,
    "proId" INTEGER NOT NULL,

    CONSTRAINT "menu_pkey" PRIMARY KEY ("menuId")
);

-- CreateTable
CREATE TABLE "order" (
    "or_id" SERIAL NOT NULL,
    "or_name" TEXT NOT NULL,
    "or_image" TEXT NOT NULL,
    "or_price" DECIMAL(65,30) NOT NULL,
    "or_quant" INTEGER NOT NULL,
    "isDeleted" BOOLEAN NOT NULL DEFAULT false,
    "manuid" INTEGER NOT NULL,
    "proid" INTEGER NOT NULL,
    "cartId" INTEGER NOT NULL,

    CONSTRAINT "order_pkey" PRIMARY KEY ("or_id")
);

-- CreateTable
CREATE TABLE "payment" (
    "pay_id" SERIAL NOT NULL,
    "or_name" TEXT NOT NULL,
    "or_quantity" INTEGER NOT NULL,
    "or_price" DECIMAL(65,30) NOT NULL,
    "totalPrice" DECIMAL(65,30) NOT NULL,
    "isPaid" BOOLEAN NOT NULL DEFAULT false,
    "orderid" INTEGER NOT NULL,

    CONSTRAINT "payment_pkey" PRIMARY KEY ("pay_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "category_cat_type_key" ON "category"("cat_type");

-- CreateIndex
CREATE UNIQUE INDEX "subcategory_subename_key" ON "subcategory"("subename");

-- AddForeignKey
ALTER TABLE "subcategory" ADD CONSTRAINT "subcategory_cat_catId_fkey" FOREIGN KEY ("cat_catId") REFERENCES "category"("catId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_catId_fkey" FOREIGN KEY ("catId") REFERENCES "category"("catId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_autherId_fkey" FOREIGN KEY ("autherId") REFERENCES "user"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart" ADD CONSTRAINT "cart_autherId_fkey" FOREIGN KEY ("autherId") REFERENCES "user"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cartItem" ADD CONSTRAINT "cartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "cart"("cartid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cartItem" ADD CONSTRAINT "cartItem_porid_fkey" FOREIGN KEY ("porid") REFERENCES "product"("proId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menu" ADD CONSTRAINT "menu_proId_fkey" FOREIGN KEY ("proId") REFERENCES "product"("proId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_proid_fkey" FOREIGN KEY ("proid") REFERENCES "product"("proId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_manuid_fkey" FOREIGN KEY ("manuid") REFERENCES "menu"("menuId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order" ADD CONSTRAINT "order_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES "cart"("cartid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payment" ADD CONSTRAINT "payment_orderid_fkey" FOREIGN KEY ("orderid") REFERENCES "order"("or_id") ON DELETE RESTRICT ON UPDATE CASCADE;
