# duckdb-docker

Runs DuckDB in a container with an accessible web UI.

## Use Cases

This Docker image is especially useful when:

- **Working with data in the cloud**: Process data directly in cloud environments, minimizing data transfer to your local machine
- **Handling S3 data**: Perform operations on S3 data more efficiently when your internet connection is limited
- **Performance testing**: Measure query performance in environments closer to your production data
- **Collaboration**: Share a consistent DuckDB environment with team members
- **Resource isolation**: Run DuckDB in a containerized environment with controlled resources
- **Cross-platform development**: Work with DuckDB consistently across different operating systems

## Architecture Support

This Docker image supports both `amd64` (x86_64) and `aarch64` (ARM64) architectures. 
The Docker container automatically detects the host architecture and runs the appropriate 
DuckDB binary.

## Usage

Run the container with port 4213 exposed:

```
docker run -p 4213:4213 -v /path/to/data:/data duckdb-docker
```

Then access the DuckDB UI by opening http://localhost:4213 in your browser.

The container automatically configures DuckDB to listen on all interfaces (0.0.0.0) so it can be accessed from the host machine.
