query = ARGV[0]

require 'json'

indent_depth = query.to_i > 0 ? query.to_i : ENV["indent_depth"].to_i

json_string = query.to_i > 0 ? ENV["clip"] : query

begin
	parsed = JSON.parse json_string
rescue JSON::ParserError
	parsed = nil
end

indent_string = ""

indent_depth.times do
	indent_string += " "
end

if parsed
	puts JSON.pretty_generate parsed, indent: indent_string
else
	output = { alfredworkflow: { arg: "", variables: { input: json_string } } }
	puts JSON.generate output
end
