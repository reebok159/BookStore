# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:book1) { create(:book) }
  let(:book2) { create(:book) }
  let(:book3) { create(:book) }
  let!(:order1) { create(:order) }
  let!(:order2) { create(:order) }

  describe 'instance methods' do
    context 'with the same order_item' do
      it 'merge 2 orders' do
        order1.order_items.push(
          create(:order_item, book: book1, quantity: 2),
          create(:order_item, book: book2, quantity: 5)
        )

        order2.order_items.push(
          create(:order_item, book: book1),
          create(:order_item, book: book2, quantity: 4),
          create(:order_item, book: book3)
        )

        result_arr_attributes = [
          { book_id: book1.id, quantity: 3 },
          { book_id: book2.id, quantity: 9 },
          { book_id: book3.id, quantity: 1 }
        ]

        order1.merge_order_items(order2)

        expect(order1.order_items.find_by(book_id: book1.id)).to have_attributes(result_arr_attributes[0])
        expect(order1.order_items.find_by(book_id: book2.id)).to have_attributes(result_arr_attributes[1])
        expect(order1.order_items.find_by(book_id: book3.id)).to have_attributes(result_arr_attributes[2])
      end
    end

    context 'with not the same order_items' do
      it 'merge 2 orders' do
        order1.order_items.push(
          create(:order_item, book: book1),
          create(:order_item, book: book2)
        )

        order2.order_items.push(
          create(:order_item, book: book3)
        )

        result_arr_attributes = [
          { book_id: book1.id, quantity: 1 },
          { book_id: book2.id, quantity: 1 },
          { book_id: book3.id, quantity: 1 }
        ]

        order1.merge_order_items(order2)

        expect(order1.order_items.find_by(book_id: book1.id)).to have_attributes(result_arr_attributes[0])
        expect(order1.order_items.find_by(book_id: book2.id)).to have_attributes(result_arr_attributes[1])
        expect(order1.order_items.find_by(book_id: book3.id)).to have_attributes(result_arr_attributes[2])
      end
    end

    context 'with empty second order' do
      it 'merge 2 orders' do
        order1.order_items.push(
          create(:order_item, book: book1),
          create(:order_item, book: book2)
        )

        order1.merge_order_items(order2)

        result_arr_attributes = [
          { book_id: book1.id, quantity: 1 },
          { book_id: book2.id, quantity: 1 }
        ]

        expect(order1.order_items.find_by(book_id: book1.id)).to have_attributes(result_arr_attributes[0])
        expect(order1.order_items.find_by(book_id: book2.id)).to have_attributes(result_arr_attributes[1])
      end

    end
  end
end
