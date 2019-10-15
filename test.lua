local proxy_mocked = require(".mocked")

local red = {
    get = function(some_key) return 'a.b.c.d' end,
}

describe("script", function()
    it("run", function()
        assert.equal(0, ngx.OK)
        assert.equal(200, ngx.HTTP_OK)
    end)
end)

describe("vars", function()
    setup(function()
        stub(ngx, 'redirect')
        local vars = {
            red = red
        }
        vars.host = 'example.com'
        vars.request_method = 'GET'
        ngx.var = mock(vars)
    end)

    teardown(function()
        mock.revert(ngx)
        mock.revert(ngx.vars)
    end)


    it("run", function()
        local result = proxy_mocked(ngx)
        assert.equal(result.var.host, 'example.com')
        assert.equal(result.var.variable, 'abcde')
    end)
end)
