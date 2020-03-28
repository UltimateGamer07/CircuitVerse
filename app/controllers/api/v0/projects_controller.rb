# frozen_string_literal: true

class Api::V0::ProjectsController < ApplicationController
  def index
    items_per_page =10 #Using different per page as per app requirements
    @projects = Project.select("id,name")
                       .where(project_access_type: "Public")
                       .paginate(page: params[:page]).limit(items_per_page)
    #@projects = Project.where(project_access_type: "Public")
    #@projects = Project.order(:name).page params[:page]
    json_string = ProjectsSerializer.new(@projects).serialized_json
    render json: json_string
  end

  def show
    @projects = Project.find(params[:id])
    if @projects.project_access_type == "Public"
      json_string = ProjectsSerializer.new(@projects).serialized_json
      render json: json_string
    else
      render plain: "The record you wish access could not be found"
    end
  end
end
