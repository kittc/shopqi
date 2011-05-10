#encoding: utf-8
class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.references :shop    , comment:  "商品应从属于商店", null: false
      t.string :title       , comment:  "标题， 例如:ipod", null: false
      t.text :description   , comment:  "商品描述"
      t.string :product_type, comment:  "类型(类别)"
      t.string :vendor      , comment:  "品牌(供应商)"
      t.string :tags        , comment: "关键词"

      t.timestamps
    end

    #图片
    create_table :photos do |t|
      t.references :product
      t.string :product_image_uid

      t.timestamps
    end

    #商品款式
    create_table :product_variants do |t|
      t.references :product        , comment: '所属商品'                          , null: false
      t.float :price               , comment: '价格'                              , null: false    , default: 0.00
      t.float :weight              , comment: '重量kg'                            , null: false    , default: 0.0
      t.float :compare_at_price    , comment: '相对价格(市场价)'
      t.string :sku                , comment: '商品唯一标识符'
      t.boolean :requires_shipping , comment: '要求送货地址'                      , default: true
      t.integer :inventory_quantity, comment: '库存'
      t.string :inventory_policy   , comment: '库存跟踪发现缺货时的处理:拒绝(deny), 继续(continue)'
    end

    add_index :products        , :shop_id
    add_index :product_variants, :product_id
    add_index :photos          , :product_id
  end

  def self.down
    drop_table :photos
    drop_table :product_variants
    drop_table :products
  end
end