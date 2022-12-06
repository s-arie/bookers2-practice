class BooksController < ApplicationController
  # ユーザーがログインしているか確認し、ログインしていない場合はログインページに遷移する
  before_action :authenticate_user!
  # 編集・更新・削除アクション実行前にユーザーが投稿者であるか確認し、投稿者のみアクションを実行できるようにする
  before_action :ensure_current_user, only[:edit, :update, :destroy]

  #新規投稿アクション
  def create
    # ビューに渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @book.new = Book.new(book_params)
    # user_idを代入
    @user.id = current_user.id
    # 投稿を保存するためのsaveメソッドを実行
    # 保存に成功した場合は投稿詳細ページへ
    if @book.save
      redirect_to book_path(@book)
    # 保存に失敗した場合は遷移しない
    else
      # 一覧ページ表示のため、Bookテーブルのデータをすべて取得する
      @books = Book.all
      render books_path
    end
  end

  # 投稿一覧画面
  def index
    #Bookテーブルのデータをすべて取得する
    @books = Book.all
    # ビューに渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @book.new = Book.new(book_params)
  end

  # 投稿詳細画面
  def show
    # 投稿idが一致する投稿を探してデータを取得する
    @book = find.Book(params[:id])
  end

  # 投稿編集画面
  def edit
  end

  #投稿編集アクション
  def update
    # 編集した投稿を更新するためのupdateメソッドを実行
    # 更新に成功した場合は投稿詳細画面へ遷移
    if @book.update(book_params)
      redirect_to book_path(@book)
    # 編集に失敗した場合は遷移しない
    else
      render edit_book_path(@book)
    end
  end

  def destroy
    # 投稿を削除するためのdestroyメソッドを実行
    # 実行後は投稿一覧へ遷移
    @book.destroy
    redirect_to books_path
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).parmit(:title,:body)
  end

  # ユーザーが投稿者であることを確認する
  def ensure_current_user
    # 投稿idが一致する投稿を探してデータを取得する
    @book = Book.find(params[:id])
    # ユーザーidが一致しない場合は投稿一覧画面に遷移する
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
