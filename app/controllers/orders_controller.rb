require 'stripe'
class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:checkout, :show, :waiter, :card, :card_success]
  before_action :find_order, :calculate_total, only: [:show, :checkout, :card]
  before_action :find_table

  def show; end

  def checkout; end

  def waiter; end

  def card 
    session = Stripe::Checkout::Session.create(
    line_items: [{
    price_data: {
      currency: "EUR",
      unit_amount_decimal:@all_items_total_price * 100,
      product_data: {
      name:"Basket"
      }
    },
    quantity: 1,
    #name:"Basket",
    #amount_decimal:@all_items_total_price,
    #currency: 'eur',
    #quantity: 1
    }],
    mode: 'payment',
    success_url: "http://localhost:3000" + '/card-success',
    cancel_url: "http://localhost:3000/" + '/cancel.html',
    )
  redirect_to session.url
  
  end



  private

  def find_order
    @order = Order.find(session[:order_id])
  end

  def calculate_total
    @all_items_total_price = 0
    @order.item_orders.each do |item_order|
      @all_items_total_price += (item_order.item.price * item_order.quantity)
    end
    @all_items_total_price = @all_items_total_price.round(2)
  end

  def find_table
    @table = Table.find(params[:table_id])
  end

end
