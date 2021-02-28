class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  get '/landmarks/new' do
    @titles = Title.all
    @figures = Figure.all
    erb :'landmarks/new'
  end 

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @figure = Figure.create(params[:figure])
      @landmark.figure_id.push(@figure.id)
    end
    !params["title"]["name"].empty? ? @figure.titles.push(Title.create(params[:title])) : nil
    redirect 'landmarks/:id'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    @figure = Figure.find_by_id(@landmark.figure_id)
    @figures = Figure.all
    @titles = Title.all
    erb :'landmarks/edit'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'landmarks/show'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.update(params["landmark"])
    if !params["figure"]["name"].empty?
      @figure = Figure.create(params[:figure])
      @landmark.figure_id = @figure.id
      @landmark.save
    end    
    redirect "landmarks/#{@landmark.id}"
  end

end
