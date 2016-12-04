Rails.application.routes.draw do
  root 'pages#landing'

  mount Messenger::Bot::Space => "/webhook"
end
