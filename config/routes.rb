Rails.application.routes.draw do
  devise_for :players
  root 'pages#landing'

  get 'admin' => 'pages#admin'

  mount Messenger::Bot::Space => "/webhook"
end
