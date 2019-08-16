class StubsController < ActionController::Base
  layout :choose_layout

  def show
    @page_files = find_pages_files
    respond_to do |format|
      format.html do
        if params[:folder] && Dir.exists?(folder_path)
          render "stubs/#{params[:folder]}/#{params[:template]}"
        else
          render params[:template]
        end
      end
    end
  end

  private

  def choose_layout
    layout = params[:layout]
    layout = params[:folder] if !layout && params[:folder] && !Dir.exists?(folder_path)
    layout || 'stubs'
  end

  def folder_path
    Rails.root.join('app', 'views', 'stubs', params[:folder])
  end

  def find_pages_files
    files = Dir[Rails.root.join('app', 'views', 'stubs', '*', '*.html.erb')]
    files.map do |file|
      file.split('/').last(2).join('/').chomp('.html.erb')
    end.sort
  end
end
