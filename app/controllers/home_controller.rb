class HomeController < ApplicationController
  def index
    readme_path = Rails.root.join('README.md')
    @readme_content = File.read(readme_path) if File.exist?(readme_path)
  end
end
