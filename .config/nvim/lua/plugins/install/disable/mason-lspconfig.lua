--=================================================================================================
		--Дополнение для mason и lspconfig
		--https://github.com/williamboman/mason-lspconfig.nvim
--=================================================================================================
return 	{
		"illiamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup()
		end,
	}
