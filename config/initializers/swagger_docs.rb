Swagger::Docs::Config.register_apis({
                                        "1.0" => {
                                            # the extension used for the API
                                            :api_extension_type => nil,
                                            # the output location where your .json files are written to
                                            :api_file_path => "public/",
                                            # the URL base path to your API
                                            :base_path => "/",
                                            # if you want to delete all .json files at each generation
                                            :clean_directory => true,
                                            # add custom attributes to api-docs
                                            :attributes => {
                                                :info => {
                                                    "title" => "SHGroup CRM RESTful APIs",
                                                    "description" => "The supported APIs provide RESTful access to the key Guest360 services ranging from accounts, stays, preferences etc."
                                                }
                                            }
                                        }
})
