# YugaRentals

Movie rentals dashboard application written in ReactJS, Node.js and YugabyteDB (or Oracle Database). This application utilizes the popular [Sakila](https://github.com/jOOQ/sakila) schema.

Interested in implementing a missing feature? Pull requests are welcomed!

<img width="1141" alt="Screen Shot 2023-03-09 at 6 42 07 PM" src="https://user-images.githubusercontent.com/2041330/224209662-31d385eb-5f8d-442d-ba34-23f453c7b37e.png">

## Deployment Options

The application can be started in several environments. Each deployment option can be configured to run with local or cloud-based database deployments.

| Deployment Type                                     | Description                                                                                          |
| --------------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| [Dockerized Deployment](local_deployment_docker.md) | Deploy the entire app with all the components (React.js, Node.js, YugabyteDB) on your local machine. |
| [Manual Installation](local_deployment.md)          | Deploy the application manually on your local machine.                                               |

## Troubleshooting

Oracle Database is not supported on machines running Apple ARM. To install the Oracle Client Libraries on Apple ARM:

- Install [Rosetta](https://support.apple.com/en-us/HT211861).
- Use Rosetta to install dependencies, following [these steps](https://developers.ascendcorp.com/how-to-install-oracle-instant-client-on-apple-silicon-m1-24b67f2dc743).
- Verify the developer, following [these steps](http://oraontap.blogspot.com/2020/01/mac-os-x-catalina-and-oracle-instant.html).
- Install Node v16 inside terminal running Rosetta.
