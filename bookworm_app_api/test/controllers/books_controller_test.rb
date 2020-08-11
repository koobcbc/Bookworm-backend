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
      post books_url, params: { book: { authors: @book.authors, canonicalVolumeLink: @book.canonicalVolumeLink, categories: @book.categories, description: @book.description, imageLinks: @book.imageLinks, language: @book.language, notes: @book.notes, pageNumber: @book.pageNumber, publisher: @book.publisher, quotes: @book.quotes, reviews: @book.reviews, starRating: @book.starRating, title: @book.title, year: @book.year } }, as: :json
    end

    assert_response 201
  end

  test "should show book" do
    get book_url(@book), as: :json
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { authors: @book.authors, canonicalVolumeLink: @book.canonicalVolumeLink, categories: @book.categories, description: @book.description, imageLinks: @book.imageLinks, language: @book.language, notes: @book.notes, pageNumber: @book.pageNumber, publisher: @book.publisher, quotes: @book.quotes, reviews: @book.reviews, starRating: @book.starRating, title: @book.title, year: @book.year } }, as: :json
    assert_response 200
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book), as: :json
    end

    assert_response 204
  end
end
