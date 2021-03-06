require "./spec_helper"

describe Libnotify do
  describe "C" do
    it "can init and uninit" do
      Libnotify::C.notify_is_initted.should eq(false)

      Libnotify::C.notify_init("test").should eq(true)
      Libnotify::C.notify_is_initted.should eq(true)

      Libnotify::C.notify_uninit
      Libnotify::C.notify_is_initted.should eq(false)
    end

    it "gets and sets app name" do
      Libnotify::C.notify_init("test")
      app_name = Libnotify::C.notify_get_app_name
      String.new(app_name).should eq("test")

      Libnotify::C.notify_set_app_name("bar")
      app_name = Libnotify::C.notify_get_app_name
      String.new(app_name).should eq("bar")
    end

    it "new" do
      summary = "Libnotify + Crystal"
      body = "version 0.1.0"
      icon_path = File.expand_path("images/crystal-120x120.png")
      notify = Libnotify::C.notify_notification_new(summary, body, icon_path)
      notify.should be_truthy

      Libnotify::C.notify_notification_show(notify, nil)
    end

    it "update" do
      summary = "Libnotify + Crystal UPDATED"
      body = "version 0.1.0 UPDATED"
      icon_path = File.expand_path("images/crystal-120x120.png")
      notify = Libnotify::C.notify_notification_new(nil, nil, nil)

      result = Libnotify::C.notify_notification_update(notify, summary, body, icon_path)
      result.should be_truthy

      Libnotify::C.notify_notification_show(notify, nil)
    end
  end
end
