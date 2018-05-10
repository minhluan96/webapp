class SharepointWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize_webhook
    token = params[:validationtoken]
    RestClient::Request.execute(
        method:  :post,
        url:     "https://saleshoodinc.sharepoint.com/sites/dientesting/_api/web/lists(guid'212e125c-f303-4c4d-9c96-5189de72ba41')/subscriptions",
        headers:
            {
                'Content-Type'                 => 'text/plain',
                'Authorization'                => "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6ImlCakwxUmNxemhpeTRmcHhJeGRacW9oTTJZayIsImtpZCI6ImlCakwxUmNxemhpeTRmcHhJeGRacW9oTTJZayJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTBmZjEtY2UwMC0wMDAwMDAwMDAwMDAvc2FsZXNob29kaW5jLnNoYXJlcG9pbnQuY29tQGJmNDQ0OGQ1LTYxZDctNGI4MS05ZjlmLThjZDc4MzkyNThkOCIsImlzcyI6IjAwMDAwMDAxLTAwMDAtMDAwMC1jMDAwLTAwMDAwMDAwMDAwMEBiZjQ0NDhkNS02MWQ3LTRiODEtOWY5Zi04Y2Q3ODM5MjU4ZDgiLCJpYXQiOjE1MjU5NDMyMzksIm5iZiI6MTUyNTk0MzIzOSwiZXhwIjoxNTI1OTQ3MTM5LCJhY3RvciI6IjhhYWRjMzBiLWVlOGEtNGE1YS1iNzhmLTkzYTU4OTVjZTBmMkBiZjQ0NDhkNS02MWQ3LTRiODEtOWY5Zi04Y2Q3ODM5MjU4ZDgiLCJpZGVudGl0eXByb3ZpZGVyIjoidXJuOmZlZGVyYXRpb246bWljcm9zb2Z0b25saW5lIiwibmFtZWlkIjoiMTAwMzNGRkZBQUI1N0YwMyJ9.fp3IWHRwOVi91AOZpCAVbGF41YFzxMtKz5wZdrCtn_p9dPUO86bn0bw-B6fmeKhYUyrZvr4vAFbptlVqvqsZxxDDGy5NwKg8JBBcOAullCOqisysS6CjgHTy5xOB2Y3pVDMFDWLPa6BZnz5HFG6zBFYdiIwTIuG4Imif2q_ubb361ls8KezeOx2c8BgT3XvPqWYwNeDFsGgb6y9xWxyTMWfUM6Am5KP05NQBufA3OHsyaoG_JPeE0hg-xSqdwvXMcLcuuI0895BP4GfDYIOWfDHj7J18rMX0arIJCK-KhCsulKn7Iv18HlPu4YEUtt0T_XpifEce5pyhg92rgz8JEw"
            },
        payload: token
    )

  end
end
