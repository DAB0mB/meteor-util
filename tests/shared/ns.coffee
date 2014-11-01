describe 'Util.ns: getOrCreate', ->
  it 'creates a new object', ->
    root = {}
    foo = Util.ns.get(root, 'path.foo')
    expect(foo).to.be.an 'object'
    expect(root.path.foo).to.exist

  it 'creates a new object from namespace as array', ->
    root = {}
    foo = Util.ns.get(root, ['path', 'foo'])
    expect(foo).to.be.an 'object'
    expect(root.path.foo).to.exist

  it 'retrieves the same object', ->
    root = {}
    foo1 = Util.ns.get(root, 'path.foo')
    foo2 = Util.ns.get(root, 'path.foo')
    expect(foo1).to.equal foo2

  it 'returns different objects from different roots', ->
    root1 = {}
    root2 = {}
    foo1 = Util.ns.get(root1, 'path.foo')
    foo2 = Util.ns.get(root2, 'path.foo')
    expect(foo1).not.to.equal foo2

  it 'returns a single level path', ->
    root = {}
    foo = Util.ns.get(root, 'foo')
    expect(root.foo).to.exist

  it 'returns nothing', ->
    root = {}
    expect(Util.ns.get()).not.to.exist
    expect(Util.ns.get(root)).not.to.exist
    expect(Util.ns.get(root, null)).not.to.exist
    expect(Util.ns.get(root, '')).not.to.exist
    expect(Util.ns.get(root, '  ')).not.to.exist


# ----------------------------------------------------------------------


describe 'Util.ns', ->
  ###
  NOTE: Root would typically be something like APP or AppName.
  ###
  ROOT = null
  beforeEach -> ROOT = {}

  it 'creates a single cached namespace', ->
    ns1 = Util.ns ROOT, 'test'
    ns2 = Util.ns ROOT, 'test'
    ns1.foo = 123
    expect(ns2.foo).to.equal 123


# ----------------------------------------------------------------------



describe 'Util.ns.toValue', ->
  __TEST = null
  ns = null
  beforeEach ->
    (global ? window).__TEST = __TEST = {}
    ns = Util.ns.get(__TEST, 'core.ns')

  afterEach -> delete (global ? window).__TEST


  it 'retrieves an object from the namespace', ->
    obj = { foo:123 }
    ns.obj = obj
    result = Util.ns.toValue('__TEST.core.ns.obj')
    expect(Util.ns.toValue('__TEST.core.ns.obj')).to.equal obj


  it 'retrieves a number from the namespace', ->
    ns.number = 123
    expect(Util.ns.toValue('__TEST.core.ns.number')).to.equal 123


  it 'does not retrieve an object from the namespace', ->
    expect(Util.ns.toValue('')).to.equal undefined
    expect(Util.ns.toValue('  ')).to.equal undefined
    expect(Util.ns.toValue()).to.equal undefined
    expect(Util.ns.toValue(null)).to.equal undefined
    expect(Util.ns.toValue('__TEST.core.ns.doesNotExist')).to.equal undefined


# ----------------------------------------------------------------------



describe 'Util.ns.toFunction', ->
  __TEST = null
  ns = null
  beforeEach ->
    (global ? window).__TEST = __TEST = {}
    ns = Util.ns.get(__TEST, 'core.ns')

  afterEach -> delete (global ? window).__TEST


  it 'retrieves a function', ->
    fn = ->
    ns.myFunc = fn
    expect(Util.ns.toFunction('__TEST.core.ns.myFunc')).to.equal fn


  it 'returns nothing if the value is not a function', ->
    ns.myText = 'Hello'
    expect(Util.ns.toFunction('__TEST.core.ns.myText')).to.equal undefined









