require 'google/api_client'

module DocumentsHelper
  
  def self.upload_file(upload, model, create_doc = true)
    file_name = upload['datafile'].original_filename  if upload['datafile'] != '' 
    file_path = upload['datafile'].tempfile.path if upload['datafile'] != ''
    file_content_type = upload['datafile'].content_type if upload['datafile'] != ''
    result = DocumentsHelper.send_to_drive(file_path, file_name, file_content_type)
    if (result.status == 200)
      drive_id = result.data.id
      if create_doc
        # create document entity to manage the file
        d = Document.create(
          :category => :file,
          :location => drive_id,
          :title => file_name,
          :user_id => model.user_id
        )
        da = ElementsAssoc.create(:element1 => model, :element2 => d)
      end
      return drive_id
    end
  end
  
  def self.send_to_drive file_path, file_name, file_content_type 
    refreshToken = ENV["GOOGLE_REFRESH_TOKEN"]
    # Prepare the OAuth client / Service Account 
    client = Google::APIClient.new(application_name: 'Google Drive File Uploader', application_version: '0.0.1')
    client.authorization = Signet::OAuth2::Client.new(
      :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
      :audience => 'https://accounts.google.com/o/oauth2/token',
      :scope => 'https://www.googleapis.com/auth/drive',
      :issuer => ENV["GOOGLE_ISSUER_EMAIL"]
    )
    
    client.authorization.client_id = ENV["GOOGLE_APP_ID"]
    client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    client.authorization.refresh_token = refreshToken
    
    # Ask for permission 
    client.authorization.fetch_access_token!
    
    # Get the Drive API
    drive = client.discovered_api('drive', 'v2')
    
    # Upload file 
    media = Google::APIClient::UploadIO.new(file_path, file_content_type)
    api_result = client.execute(
        :api_method => drive.files.insert,
        :parameters => { 'uploadType' => 'multipart' },
        :body_object => { 'title' => file_name, 'parents' => [{"id" => ENV["DEFAULT_DRIVE_FOLDER_ID"]}]},
        :media => media)
    
    return api_result 
  end
  
end
