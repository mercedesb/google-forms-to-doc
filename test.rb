require './services/google_sheets_service.rb'
require './services/google_docs_service.rb'

# if ARGV[0]
#   sheet_id = ARGV[0]
# else
#   puts 'Sheet Id:'
#   sheet_id = gets.chomp
# end

# get sheets data
# sheets_svc = GoogleSheetsService.new
# sheet_id = "1V2xxM7dq5feYGO3PtCh4_1918xYkQdAIaJdgOpKo1GU"
# values_to_write = sheets_svc.batch_get_values(sheet_id, "B1:D50")

# copy template document
docs_svc = GoogleDocsService.new
doc_id = "1grbhjk5nGN6N-NeGoO8dD_1aQ0Ui_sw4iWDi8uHKuNA"
new_file_name = "new file"
response = docs_svc.copy(doc_id, new_file_name)

new_doc_id = response.id #"1OvHLCX2k3pC2VqYAQm5U0OphGM5NyOGgvv-_XdvouAs"
response = docs_svc.export(new_doc_id)
new_content = response.string
new_content = new_content.gsub('[COLUMNB]', "b column test").gsub('[COLUMNC]', "c column test").gsub('[COLUMND]', "d column test")
docs_svc.update(new_doc_id, new_content)


# get copy's content
# update with sheets data

