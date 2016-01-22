## Overview
This a quick demo to show how could we attach `pre` or `post` hooks to [dnode](https://github.com/substack/dnode) methods.

## Install & Run

``` bash
npm i
```

Run a vanilla [dnode](https://github.com/substack/dnode) demo.
``` bash
> npm test withoutHook.coffee
... some npm output
--original func calls
beep => BOOP
```

And then you can run the hooked version:
``` bash
> npm test withHook.coffee
... some npm output
before transform
--original func calls
after transform!
beep => BOOP
```

## How It works

I'm using [grappling-hook](https://github.com/keystonejs/grappling-hook) to do the hook things and just make the hooked object as clean as that could be transfered to the client.

See the source for the implementations.