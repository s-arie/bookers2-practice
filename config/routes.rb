Rails.application.routes.draw do

  # ユーザーログイン
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # トップ画面
  root to: "homes#top"
  # アバウト画面
  get 'homes/about'
  # ユーザー一覧・詳細・編集・更新
  resources :users, only: [:index, :show, :edit, :update]
  # 新規投稿・投稿一覧・詳細・編集・更新・削除
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
end
