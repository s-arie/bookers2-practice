class UsersController < ApplicationController
  # ユーザーがログインしているか確認し、ログインしていない場合はログインページに遷移する
  before_action :authenticate_user!
  # 編集・更新アクション実行前にユーザーが投稿者であるか確認し、投稿者のみアクションを実行できるようにする
  before_action :ensure_current_user, only[:edit, :update]

  # ユーザー一覧画面
  def index
    # ユーザーテーブルのデータをすべて取得する
    @users = User.all
    #Bookテーブルのデータをすべて取得する
    @books = Book.all
    # ビューに渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @book.new = Book.new(book_params)
  end

  # ユーザー詳細画面
  def show
    # ユーザーidと一致するユーザーを探してデータを取得
    @user = find.User(params[:id])
    # ビューに渡すためのインスタンス変数に空のモデルオブジェクトを作成
    @book.new = Book.new(book_params)
  end

  def edit
  end

  def update
    # 編集したユーザー情報を更新するためのupdateメソッドを実行
    # 更新に成功した場合はユーザー詳細画面へ遷移
    if @user.update(user_params)
      redirect_to user_path(@user)
    # 編集に失敗した場合は遷移しない
    else
      render edit_user_path(@user)
    end
  end

  # ユーザーが投稿者であることを確認する
  def ensure_current_user
    # ユーザーidが一致するユーザーを探してデータを取得する
    @user = User.find(params[:id])
    # ユーザーidが一致しない場合は操作しているユーザーの詳細ページに遷移する
    unless book.user == current_user
      redirect_to user_path(current_user)
    end
  end
end
