# How does data compression affect CO2 emission in Nginx?

Does enabling gzip compression in the nginx configuration have the potential to
save 5.7k tons of CO2?

That was my initial question as I noticed that the [default configuration of
Nginx is turned
off](https://raw.githubusercontent.com/nginx/nginx/master/conf/nginx.conf).
[Read about the calculation in this
article](https://typeshare.co/ti/posts/want-to-make-your-web-service-greener-this-single-flag-in-your-nginx-configuration-decreases-your-carbon-emission).
I posted about that on
[LinkedIn](https://www.linkedin.com/posts/torsten-irlaender_til-greensoftware-ngnix-activity-7235179509849739264-jBN4?utm_source=share&utm_medium=member_desktop)
and got some valuable feedback. And it shows this question is something people
resonates with.

Of course this is not a black-and-white answer. There a many factors to consider.
However one of the things that got mentioned most in the discussion was that the
compression cost additional energy on client and server that might outweigh
the savings coming from reduced data transfer.

That is a very interesting question that I would like to answer.

Within this repository I want to create a transparent measurement setting to
bring more light into this question, and of course, to learn more about
measurements.

## Setup

My plan:

Use [[Green Metrics Tool]](https://docs.green-coding.io) for Tests on [Hosted Service](https://metrics.green-coding.io)
To make this happen the following things must be done:

- Use docker image with a slim Nginx Setup
- Use "stress" image with a [wrk](https://github.com/wg/wrk) installed to stress the server
- Create testdata to be served by the server.
- Create a `usage_scenario.yml` file with flow to stress Nginx by loading this test files.
- Run the tests in different configuration (compression enabled/disabled)

### Testdata

There are three different types of data in different sizes (1kB, 10kB, 100kB, 1MB, 10MB):

- Textfiles with repetitive content (easily compressible)
- Textfiles with random content (poorly compressible)
- Textfiles with binary content (e.g. JPEG)

Testdata can be (re)generated with

```sh
sh ./generate-testdata.sh
```

## Results

> Wer misst misst Mist

A german saying that states that often measurements lead to confusion as the are probably done wrong.

That's true and that is the reason why I want to be transparent on the process here.

Here is a short history of different measurement settings and (probably wrong findings).

### v0.1.0

First measurement. Result only shows that measurement setting is wrong.

Too much load on the sever. Can not seen any difference whether I load small,
large or compressed or uncompressed files. wrk seems to put the server under
heavy load. Server is at 100% no matter what phase in test.

Conclusion: Find a better setting. I want to be able to see a difference in
workload between sending a uncompressed 1KB file and a compressed 10MB file.
