local function run(ngx, stub)
    local proxy_mocked = {}
    local redis_host = os.getenv("REDIS_HOST")

    if not redis_host then
        redis_host = "redis"
    end

    if not ngx.var.host then
        ngx.log(ngx.ERR, "no host found")
        return render_error("404.html", 400);
    end
	
	local host, err = ngx.var.red.get('route')
    if not host then
        ngx.log(ngx.ERR, "failed to get redis key: ", err)
        return render_error("500.html", 500);
    end

	ngx.var.red_host = host
    ngx.var.variable = 'abcde'

    return ngx
end
return run
