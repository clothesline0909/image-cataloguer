# Image Cataloguer

A batch processor that takes an XML file of EXIF exported data and produces a catalog of images.

## Environments

This project was tested on Ubuntu 14.04.

## System Dependencies & Configuration

This application requires Ruby >= 2.3.0.

To install Ruby visit: http://rubyinstaller.org/.

To check your version run:

    $ ruby -v

## Installation

To run this project you must have Ruby installed (tested version 2.2.4).

    $ git clone https://github.com/clarkbab/document-api.git
    $ cd document-api
    $ gem install bundler
    $ bundle install

You must perform the database migrations.

  $ rake db:migrate

You may also have to perform these to run the RSpec tests.

  $ rake db:migrate RAILS_ENV=test

## Running

First we must start the Rails server from the project directory. Note the port number that it utilises.

    $ rails server

This API can be accessed using the Postman Google Chrome extension or similar.

Initially, you will have to populate the database with some values for the models: Users (Authors), Tags, Categories and Documents.

You must first create users. This is the only route that doesn't require authentication, for testing purposes.

### POST 'api/v1/users'

JSON request body example: 
```
{
  "user": {
    "name": "Supervisor"
  }
}
```
This will create a User with an api_token. The tokens for Users can be viewed at: GET 'api/v1/users'
```
[{
  "users": {
    "id": 1,
    "name": "supervisor",
    "api_token":"Yru17Kb5jAx6GIoq2rhFU7U6g5cmmYbJ1tq3sPvg"
  }
}]
```

These api_token values would normally be hidden but are shown here to allow a tester to authenticate.

### Authentication

We can authenticate by including the header 
```
Authorization: Token token=Yru17Kb5jAx6GIoq2rhFU7U6g5cmmYbJ1tq3sPvg
```
 with a token matching one of the User's API tokens, in our HTTP requests.

### POST 'api/v1/tags', 'api/v1/categories'

Create Tags and Categories by POSTing for example:
```
{
  "tag": {
    "name": "Classified"
  }
}
```

and GETting:
```
[{
  "tag": {
    "id": 1
    "name": "Classified"
  }
}]
```

### POST 'api/v1/documents'

After we have created Users, Tags and Categories, we can create Document objects.

```
{
    "document": {
        "title": "this is my title.",
        "size": 10.8,
        "content_status": "in work",
        "content_type": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "availability": "available offline",
        "pages": 1,
        "subject": "personal information",
        "comments": "this is a classified document",
        "computer": "philliplaptopw",
        "editing_time": 180,
        "users": [1, 2],
        "tags": [2, 3],
        "categories": [3],
        "last_saved_by": 2
    }
}
```

### GET 'api/v1/documents'

The following is a list of query parameters which may be added to the GET request to get a subset of Document objects:

* title
* min_size
* max_size
* min_updated_at
* max_updated_at
* min_created_at
* max_created_at
* content_status
* content_type
* availability
* min_pages
* max_pages
* subject
* comments
* min_date_accessed
* max_date_accessed
* computer
* min_content_created
* max_content_created
* min_content_saved
* max_content_saved
* min_editing_time
* max_editing_time
* users
* tags
* categories
* last_saved_by

Number fields are matched using numerical comparison such that for all documents that have more than 100 pages:
```
.../api/v1/documents?min_pages=101
```

String fields are matched using a 'like' comparison. Will show all documents whose titles contain 'title':
```
.../api/v1/documents?title=title
```

Date field query parameters the format YYYY-mm-dd, such that the 13th June 2016 would be entered:
```
../api/v1/documents?min_updated_at=2016-06-13
```

Naturally, query parameters can be chained:
```
../api/v1/documents?title=second%20project&min_pages=5&max_date_created=2016-05-12
```

For parameters that can have multiple values (Users, Categories and Tags), list IDs in a comma-separated list:
```
../api/v1/documents?categories=1,2,3&users=1
```

### Other Routes

Other routes that act on the Documents resources are:

```
SHOW    ../api/v1/documents/:id
PUT     ../api/v1/documents/:id
PATCH   ../api/v1/documents/:id
DELETE  ../api/v1/documents/:id
```

PUTs and UPDATEs are carried out with the same resquest body format as POSTs to create Documents.

## Testing

Testing is carried out using RSpec either individually or in groups.

    $ rspec                                     # Performs all files matching *_spec.rb in spec and sub-folders.
    $ rpsec spec/models                         # Runs all spec files in models and sub-folders.
    $ rspec spec/models/document_spec.rb        # Runs a single spec file.

## Licence

This project, document-api, is licensed under the GNU Lesser General Public License.


