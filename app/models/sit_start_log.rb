class SitStartLog < RemoteTableModel
	self.table_name = "log_lineup_changes"
	scope :huddle, where(app: "Huddle")
	scope :bunt, where(app: "Bunt")
end