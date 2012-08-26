class HomeController < ActionController::Base
  
  def index   
    #Authentication using the AppID and Secret Key 
   	session[:oauth] = Koala::Facebook::OAuth.new('433892453319919', 'f6775d603249c9ac6cd7550d267e0189', 'http://myfbapitest.herokuapp.com/' + '/home/callback')
		@auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream") 	
  end

	def callback
  	if params[:code]
  		# acknowledge code and get access token from FB
		  session[:access_token] = session[:oauth].get_access_token(params[:code])
		end		
		 # auth established, now do a graph call:
		@graph = Koala::Facebook::API.new(session[:access_token])		
		#Get the Test Post
		@graph_post = @graph.get_object("/10152063391310252")
		#Get the Comments for the Test Post
		@graph_data = @graph.get_object("/10152063391310252/comments/")	
	end
end

