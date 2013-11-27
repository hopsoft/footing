require File.expand_path("../test_helper", __FILE__)

class FootingTest < MicroTest::Test

  test "patch a class" do
    class Foo; end
    module FooClassPatch
      def foo
        :foo
      end
    end

    Footing.patch! Foo, FooClassPatch
    o = Foo.new
    assert o.respond_to? :foo
    assert o.foo == :foo
  end

  test "patch an instance" do
    module FooInstancePatch
      def foo
        :foo
      end
    end

    o = Object.new
    Footing.patch! o, FooInstancePatch
    assert o.respond_to? :foo
    assert o.foo == :foo
  end

  test "setup util methods" do
    module FooUtil
      def foo(arg)
        "foo#{arg}"
      end
    end

    Footing.util! FooUtil
    assert FooUtil.respond_to? :foo
    assert FooUtil.foo(nil, "bar") == "foobar"
  end

end
