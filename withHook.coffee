dnode = require 'dnode'
net = require 'net'
grappling = require 'grappling-hook'

log = console.log.bind console
error = console.error.bind console

apis =
    transform: (s, cb) ->
        log '--original func calls'
        cb null, s.replace(/[aeiou]{2,}/, 'oo').toUpperCase()

wrap = (apis) ->
    instance = grappling.create()
    instance.addHooks apis

    hooked = {}
    hooked[k] = instance[k] for k of apis
    { instance, hooked }

{instance, hooked} = wrap apis

# Equip middlewares
# Callback func MUST have same numbers of arguments as the origin
instance.pre 'transform', (s, done) ->
    log 'before transform'
    done()
.post 'transform', (s, done) ->
    log 'after transform!'
    done()

server = net.createServer (c) ->
    d = dnode hooked
    c.pipe(d).pipe c

server.listen 5004

d = dnode()
d.on 'remote', (remote) ->
    remote.transform 'beep', (err, s) ->
        if err?
            error 'Errors', err
        else
            log 'beep => ' + s
        d.end()

c = net.connect 5004
c.pipe(d).pipe c