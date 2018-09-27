# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, except: %i[show]
  resources :groups, except: %i[show]
  resource :sessions, only: %i[create destroy]

  resources :workflows do
    scope module: :workflows do
      resources :fields, except: %i[show] do
        scope module: :fields do
          resource :validations, only: %i[edit update]
          resource :options, only: %i[edit update]
        end
      end
      resources :transitions, except: %i[show] do
        scope module: :transitions do
          resource :options, only: %i[edit update]
        end
      end
      resources :instances, only: %i[index show create] do
        scope module: :instances do
          resources :tokens, only: %i[index show] do
            post "fire"
          end
        end
      end

      resource :load, only: %i[show update]
    end
  end

  root to: "workflows#index"
end
