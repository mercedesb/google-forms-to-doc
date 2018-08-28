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
require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleSheetsService < BaseGoogleService
  SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS
  CREDENTIALS_PATH = 'google_sheets_token.yaml'.freeze

  def initialize
    super(scope: SCOPE, credentials_path: CREDENTIALS_PATH)
    # Initialize the API
    @service = Google::Apis::SheetsV4::SheetsService.new
    @service.authorization = authorize
  end

  def get_values(spreadsheet_id, range_name)
    result = @service.get_spreadsheet_values(spreadsheet_id, range_name)
    num_rows = result.values ? result.values.length : 0
    puts "#{num_rows} rows received."
    result
  end

  def batch_get_values(spreadsheet_id, range_names)
    result = @service.batch_get_spreadsheet_values(spreadsheet_id,
                                                  ranges: range_names,
                                                  major_dimension: "ROWS")
    result
  end
end