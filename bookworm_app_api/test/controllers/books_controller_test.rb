require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  test "should get index" do
    get books_url, as: :json
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { book: { googleBooksId: @book.googleBooksId, notes: @book.notes, quotes: @book.quotes, reviews: @book.reviews, starRating: @book.starRating, title: @book.title, user_id: @book.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show book" do
    get book_url(@book), as: :json
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { googleBooksId: @book.googleBooksId, notes: @book.notes, quotes: @book.quotes, reviews: @book.reviews, starRating: @book.starRating, title: @book.title, user_id: @book.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book), as: :json
    end

    assert_response 204
  end
end
