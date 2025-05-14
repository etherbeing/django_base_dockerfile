from argparse import ArgumentParser
import os

DEFAULT_TARGET_PATHS = {
    "nginx": "/etc/nginx/sites-enabled",
    "apache": "/etc/apache2/sites-enabled",
    "caddy": "/etc/caddy/sites-enabled"
    # Add more web servers and their default paths if needed
}

def main():
    parser = ArgumentParser(description="Deploy formatted web server config.")
    parser.add_argument("webserver", help="The name of the web server (e.g., nginx, apache)")
    parser.add_argument("domain_name", help="The domain name used to publish this site")
    args = parser.parse_args()

    webserver = args.webserver
    cwd = os.getcwd()
    config_dir = os.path.join(cwd, webserver)
    config_file_path = os.path.join(config_dir, "example.conf")

    if not os.path.isfile(config_file_path):
        raise FileNotFoundError(f"Configuration file '{config_file_path}' not found.")

    with open(config_file_path, "r") as f:
        config_template = f.read()

    try:
        formatted_config = config_template.format({**os.environ, DOMAIN_NAME: args.domain_name})
    except KeyError as e:
        raise KeyError(f"Missing environment variable for placeholder: {e}")

    target_dir = DEFAULT_TARGET_PATHS.get(webserver.lower())
    if not target_dir:
        raise ValueError(f"Unsupported web server: {webserver}")

    os.makedirs(target_dir, exist_ok=True)  # In case the dir was removed
    target_file_path = os.path.join(target_dir, f"{os.environ.get("NAME", "django_project")}.conf")

    with open(target_file_path, "w") as f:
        f.write(formatted_config)

    print(f"Deployed config to: {target_file_path}")

if __name__ == "__main__":
    main()
