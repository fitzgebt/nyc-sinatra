class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end 

  post '/figures' do
    @figure = Figure.create(params[:figure])
    !params["title"]["name"].empty? ? @figure.titles.push(Title.create(params[:title])) : nil    
    !params["landmark"]["name"].empty? ? @figure.landmarks.push(Landmark.create(params[:landmark])) : nil
    redirect to 'figures/:id'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do

    @figure = Figure.find_by_id(params[:id])
    @figure.update(params["figure"])
    !params["title"]["name"].empty? ? @figure.titles.push(Title.create(params[:title])) : nil    
    !params["landmark"]["name"].empty? ? @figure.landmarks.push(Landmark.create(params[:landmark])) : nil
    redirect "/figures/#{@figure.id}"

  end

end
