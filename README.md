# ale - raggi's brew taps

These formulae provide software either written by me, or tap'd by me. Use at
your own discretion.

## How do I install these formulae?
--------------------------------

### Using taps (recommended way)
Just `brew tap raggi/ale` and then `brew install <formula>`.

If the formula conflicts with one from mxcl/master or another tap, you can `brew install raggi/ale/<formula>`.


### Downloading the formula and manually installing (Alternate)
You can also download the formula and directly install it:

```
wget https://raw.github.com/raggi/ale/master/openssl-osx-ca.rb
brew install --HEAD -s ./openssl-osx-ca.rb
```

### Directly installing from URL (Not recommended and only for older versions of homebrew)
If you have older versions of brew, you can try directly installing from a URL:

```
brew install https://raw.github.com/raggi/ale/master/<formula>.rb
```

Docs
----
`brew help`, `man brew`, or the Homebrew [wiki][].

[wiki]:http://wiki.github.com/mxcl/homebrew
