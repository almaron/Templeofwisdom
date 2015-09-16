class RenameForumDraftToForumPostDraft < ActiveRecord::Migration
  def change
    rename_table :forum_drafts, :forum_post_drafts
  end
end
