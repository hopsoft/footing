require File.join(File.dirname(__FILE__), "spec_helper")

describe Footing do

  it "should patch a class" do
    class Foo
    end
    module FooClassPatch
      def foo
        :foo
      end
    end

    Footing.patch! Foo, FooClassPatch
    o = Foo.new
    assert { o.respond_to? :foo }
    assert { o.foo == :foo }
  end

  it "should patch an instance" do
    module FooInstancePatch
      def foo
        :foo
      end
    end

    o = Object.new
    Footing.patch! o, FooInstancePatch
    assert { o.respond_to? :foo }
    assert { o.foo == :foo }
  end

  it "should setup util methods" do
    module FooUtil
      def foo(arg)
        "foo#{arg}"
      end
    end

    Footing.util! FooUtil
    assert { FooUtil.respond_to? :foo }
    assert { FooUtil.foo("bar") == "foobar" }
  end

end