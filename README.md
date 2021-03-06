# Introduction

This script submits Jenkins environment data to a RESTful key-value store of
your choosing. Ideal for powering dashboards.

# Dependencies

[curl](http://curl.haxx.se/)

# Usage

## Download

From your Jenkins job, define an `Execute Script` step which downloads the
script into your workspace:

    curl -O https://raw.githubusercontent.com/opyate/dashkins/master/da.sh
    chmod +x da.sh


The app can choose to have a [.da.sh](.da.sh) file in the root of the project
which will populate the `app` key in the resulting JSON before submitting it to
the key-value store.

## Run

Then run the script, providing the `curl` parameters responsible for
authentication (if required) and the location of the key-value store:

    ./da.sh -u mykvusername:mykvpassword http://mykvstore.example.org/api/$JOB_NAME

Or without authentication:

    ./da.sh http://mykvstore.example.org/api/$JOB_NAME

Alternatively, set an environment variable called `CURL_KV` and set it to the
values above:

    export CURL_KV="-u mykvusername:mykvpassword http://mykvstore.example.org/api/$JOB_NAME"
    ./da.sh

Example without authentication, which is really just the location:

    export CURL_KV="http://mykvstore.example.org/api/$JOB_NAME"
    ./da.sh

# Other

Now that you have a populated key-value store, head over to [freeboard.io](https://freeboard.io) and point the widgets to the KV service for fun and profit.

## Adding buttons that does stuff to freeboard.io

Add an HTML widget type. In the `HTML` field, click on `.JS EDITOR`, and add something like this:


    return (function() {
        var butt = $('<button/>')
            .text('Promote')
            .click(function () { alert('Deploying to test...'); });
        return butt[0];
    })();
