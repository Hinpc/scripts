#/bin/sh
# 下载 github 私有仓库的最新 release 文件
# 用法 dl-private-gh-release <user>/<repo> <token>
# ref: https://gist.github.com/illepic/32b8ad914f1dc80446c7e81c3be4e286

api_url_release="https://api.github.com/repos/$1/releases/latest"

if [ ! -n "$1" ]; then
    echo "请输入参数 <user>/<repo>"
elif [ ! -n "$2" ]; then
    echo "请输入 token"
elif ! type jq >/dev/null 2>&1; then
    echo "jq 未安装, exit"
    exit 1
else
    asset_id=`curl -H "Authorization: token $2" -sSL $api_url_release | jq -r ".assets[0].id"`
    echo "asset_id:" $asset_id

    api_url_asset="https://api.github.com/repos/$1/releases/assets/$asset_id"
    # curl:
    # -O: Use name provided from endpoint
    # -J: "Content Disposition" header, in this case "attachment"
    # -L: Follow links, we actually get forwarded in this request
    # -H "Accept: application/octet-stream": Tells api we want to dl the full binary
    curl -O -J -L -H "Authorization: token $2" -H "Accept: application/octet-stream" $api_url_asset
fi
