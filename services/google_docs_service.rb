# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# [START sheets_quickstart]

require './services/base_google_service'
require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleDocsService < BaseGoogleService
  SCOPE = Google::Apis::DriveV3::AUTH_DRIVE
  CREDENTIALS_PATH = 'google_docs_token.yaml'.freeze

  def initialize
    super(scope: SCOPE, credentials_path: CREDENTIALS_PATH)
    # Initialize the API
    @service = Google::Apis::DriveV3::DriveService.new
    @service.authorization = authorize
  end

  def copy(doc_id, name)
    @service.copy_file(doc_id, Google::Apis::DriveV3::File.new(name: name))
  end

  def export(doc_id)
    @service.export_file(doc_id, "text/plain", download_dest: StringIO.new)
  end

  def update(doc_id, text_content)
    @service.update_file(doc_id, nil, { upload_source: StringIO.new(text_content) })
  end
end